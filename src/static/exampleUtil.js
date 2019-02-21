function getGraph(callback) {
    $.get('/api/nodes', function (nodes) {
        $.get('/api/edges', function (edges) {
            return callback(false, { nodes: nodes, edges: edges });
        });
    });
}
