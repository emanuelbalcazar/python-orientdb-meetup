function getGraph(callback) {
    $.get('/api/nodes', function (data) {
        return callback(false, data);
    });
}
