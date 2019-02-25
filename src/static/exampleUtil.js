var nodes = null;
var edges = null;
var network = null;
var data = null;

var seed = 2;

function destroy() {
    if (network !== null) {
        network.destroy();
        network = null;
    }
}

function getGraph(callback) {
    $.get('/api/nodes', function (nodes) {
        $.get('/api/edges', function (edges) {
            return callback(false, { nodes: nodes, edges: edges });
        });
    });
}

function draw() {
    destroy();

    // create a network
    var container = document.getElementById('my_network');

    var options = {
        locale: 'es',
        edges: {
            arrows: {
                to: true,
            }
        },
        interaction: {
            navigationButtons: true,
            hoverConnectedEdges: false
        },
        manipulation: {
            addNode: function (data, callback) {
                // filling in the popup DOM elements
                document.getElementById('operation').innerHTML = "Agregar nodo";
                document.getElementById('node-id').value = data.id;
                document.getElementById('node-label').value = data.label;
                document.getElementById('saveButton').onclick = saveData.bind(this, data, callback);
                document.getElementById('cancelButton').onclick = clearPopUp.bind();
                document.getElementById('network-popUp').style.display = 'block';
            },
            editNode: function (data, callback) {
                // filling in the popup DOM elements
                document.getElementById('operation').innerHTML = "Editar Nodo";
                document.getElementById('node-id').value = data.id;
                document.getElementById('node-label').value = data.label;
                document.getElementById('saveButton').onclick = saveData.bind(this, data, callback);
                document.getElementById('cancelButton').onclick = cancelEdit.bind(this, callback);
                document.getElementById('network-popUp').style.display = 'block';
            },
            addEdge: function (data, callback) {
                if (data.from == data.to) {
                    var r = confirm("¿Quiere conectarse a si mismo?");
                    if (r == true)
                        callback(data);
                }
                else {
                    callback(data);
                }
            }
        }
    };

    getGraph(function (err, result) {
        data = result
        network = new vis.Network(container, data, options);
    });
}

function clearPopUp() {
    document.getElementById('saveButton').onclick = null;
    document.getElementById('cancelButton').onclick = null;
    document.getElementById('network-popUp').style.display = 'none';
}

function cancelEdit(callback) {
    clearPopUp();
    callback(null);
}

function saveData(data, callback) {
    data.id = document.getElementById('node-id').value;
    data.label = document.getElementById('node-label').value;
    clearPopUp();
    callback(data);
}

function init() {
    draw();
}