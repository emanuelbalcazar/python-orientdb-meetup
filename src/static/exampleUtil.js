function getGraph(callback) {
    $.get('/api/nodes', function (nodes) {
        $.get('/api/edges', function (edges) {

            nodes = nodes.map(n => n.label = n.nombre)
            edges = nodes.map(e => e.label = n.nombre)

            return callback(false, { nodes: nodes, edges: edges });
        });
    });
}
