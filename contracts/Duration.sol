import "./FlexCoin.sol";

pragma solidity ^0.4.11;
contract Duration {

    struct Node {
        address owner;
        uint nodeID;
        uint numDemandHours;
        string demandPrices;
        string supplyHours;
    }

    uint public numNodes;
    mapping(uint => Node) public nodes;

    function setNode(uint _numDemandHours, string _demandPrices, string _supplyHours) public {
        Node n = nodes[numNodes];
        n.owner = msg.sender;
        n.nodeID = numNodes;
        n.numDemandHours = _numDemandHours;
        n.demandPrices = _demandPrices;
        n.supplyHours = _supplyHours;
        numNodes = numNodes + 1;
        // si no functiona con array como ingreso, pone un uint 01010111000.
    }
    // gas cost: 206 205
    // lo tengo que Comprobar contra gasTransactions(). receipt
// 131501 con 5-6 steps
// 198 000 con 20 steps
    // Quiza la supply puede involver una variable que dice algo sobre la probilidad.
    // Por ejemplo; Un supply mas pronto deberia tiene un probilidad mas alto.
    // Que vas a hacer con lo? Combina alto prob aqui con alto prob abajo? hmm.

    function getNode(uint _nodeID) constant public returns(address, uint, string, string){
        return (nodes[_nodeID].owner, nodes[_nodeID].numDemandHours, nodes[_nodeID].demandPrices, nodes[_nodeID].supplyHours);
    }

    function checkAndTransfer(uint[] sortedList, uint[] from, uint[] to, uint[] price, uint timeStep, address contractAddress) public returns(bool success) {
        // Because solidity not can receive two dimension list, we must call this for every time step
        FlexCoin f = FlexCoin(contractAddress);

        uint i = 0;
        if (sortedList.length > 1) {
        // Este puede ser equivocado! length puede dar length de un string/byte.
            for (i; i < (sortedList.length - 1); i++) {
                f.transferHouse(nodes[from[i]].owner, nodes[to[i]].owner, price[from[i]]);
            }
        }
        f.transferHouse(nodes[from[i]].owner, nodes[to[i]].owner, price[from[i]]);
    }
    // gas cost: 59033
}
