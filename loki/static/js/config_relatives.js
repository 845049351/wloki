require([
    'jquery',
    'loki',
    'util/datatables',
    'util/tab-view',
], function($, loki, datatables, tabview) {
    loki.configure({
        restrict_nodes: true
    });


    var permillage_to_percent = function(v) {
        return (v * 100).toFixed(1);
    };


    loki.defineTabParamsHandler(function(params) {
    });


    /* Tab Views */

    var ConfigView = tabview.TabView.extend({
        tab_name: 'Config',
        ptree_config: {
            mode: 'disable',
            levels: [-1]
        },
        $el: $('#tab-1'),
        events: {
        },

        initialize: function() {
            var view = this;
            var tabletools_config = {
                "sRowSelect": "os",  // or 'multi'
                "aButtons": [
                    {
                        sExtends: 'select_none',
                        sButtonText: '取消选择'
                    }
                ]
            };

            // Tables
            if (!loki.nodeConfigTable) {
                loki.nodeConfigTable = datatables.createDataTable(
                    $('.node-config table'),
                    {
                        columns: [
                            {data: 'name'}
                        ],
                        tableTools: tabletools_config
                    },
                    $('.node-config .fn-search')
                );
            }
            if (!loki.availableConfigTable) {
                loki.availableConfigTable = datatables.createDataTable(
                    $('.free-config table'),
                    {
                        columns: [
                            {data: 'name'},
                        ],
                        tableTools: tabletools_config
                    },
                    $('.free-config .fn-search')
                );
            }

            // Events
            $('.node-config').on('click', 'tr,.DTTT_button', function() {
                var selected = loki.nodeConfigTable.rows('.selected').data();
                if (selected.length) {
                    $('.fn-remove-config').disable(false);
                } else {
                    $('.fn-remove-config').disable();
                }
            });

            $('.free-config').on('click', 'tr,.DTTT_button', function() {
                var selected = loki.availableConfigTable.rows('.selected').data();
                if (selected.length) {
                    $('.fn-add-config').disable(false);
                } else {
                    $('.fn-add-config').disable();
                }
            });

            var disableButtons = function() {
                $('.fn-add-config').disable();
                $('.fn-remove-config').disable();
            };

            // Buttons
            $('.fn-add-config').click(function() {
                var dt = loki.availableConfigTable,
                    rows = dt.rows('.selected').data(),
                    node = loki.getCurrentNode(),
                    btn = $(this);

                config = rows[0].name

                disableButtons();
                view.addConfig(node, config);
            });

            $('.fn-remove-config').click(function() {
                var dt = loki.nodeConfigTable,
                    rows = dt.rows('.selected').data(),
                    node = loki.getCurrentNode(),
                    btn = $(this);

                config = rows[0].name

                disableButtons();
                view.removeConfig(node, config);
            });

            if(typeof(String.prototype.strip) === "undefined") {
                String.prototype.strip = function() {
                    return String(this).replace(/^\s+|\s+$/g, "");
                };
            }
        },

        handleParams: function(params) {
            var view = this;
            var node = loki.getCurrentNode();
            if (!node)
                return;

            if (!node.state.disabled) {
                console.log('valid node, render config');
                view.renderNodeConfig(params.nid);
                view.renderAvailableConfig(params.nid);
                view.enableTab();
            } else {
                console.log('invalid node, clean UI');
                view.disableTab('只允许在倒数第二层节点管理配置');
            }
        },

        renderNodeConfig: function(node_id) {
            var dt = loki.nodeConfigTable,
                query = {
                },
                jqxhr;

            dt.displayProcessing();

            jqxhr = $.ajax({
                url: '/api/config/' + node_id,
                data: query,
                type: 'GET'
            }).then(function(json) {
                dt.reloadData(json.data);
                dt.displayProcessing(false);
            });

            return jqxhr;
        },

        renderAvailableConfig: function(node_id) {
            var dt = loki.availableConfigTable,
                query = {
                },
                jqxhr;

            dt.displayProcessing();

            jqxhr = $.ajax({
                url: '/api/config/classes',
                type: 'GET',
                data: query
            }).then(function(json) {
                dt.reloadData(json.data);
                dt.displayProcessing(false);
                dt.nid = node_id;
            });

            return jqxhr;
        },

        addConfig: function(node, config) {
            var view = this;

            var data = {
                    name: config
                },
                defer = $.Deferred();

            $.ajax({
                url: '/api/config/' + node.id,
                method: 'PUT',
                data: JSON.stringify(data),
                success: function() {
                  loki.notify("config added successfully");
                },
                error: function(resp) {
                  loki.ajax_error_notify(resp);
                }
            }).always(function() {
                $.absoluteWhen(
                    view.renderNodeConfig(node.id),
                    view.renderAvailableConfig(node.id)
                ).then(function() {
                    defer.resolve();
                });
            });

            return defer;
        },

        removeConfig: function(node, config) {
            var view = this;

            var data = {
                },
                defer = $.Deferred();

            $.ajax({
                url: '/api/config/' + node.id,
                method: 'DELETE',
                data: JSON.stringify(data),
                success: function() {
                  loki.notify("config removed successfully");
                },
                error: function(resp) {
                  loki.ajax_error_notify(resp);
                }
            }).always(function() {
                $.absoluteWhen(
                    view.renderNodeConfig(node.id),
                    view.renderAvailableConfig(node.id)
                ).then(function() {
                    defer.resolve();
                });
            });

            return defer;
        },

    });


    tabview.registerTabViews(ConfigView);


    loki.registerAjaxError();
    loki.run();
});
