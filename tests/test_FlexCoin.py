from random import randint

### This function is made to test the contract on the blockchain

def test_match(chain):

    flexCoin, _ =chain.provider.get_or_deploy_contract('FlexCoin')
    supply = [[0 for x in range(10)] for y in range(2)];
    demand = [[0 for x in range(10)] for y in range(2)];

    for i in range(0,10):
        supply[i][0] = i;
        demand[i][0] = i;
        supply[i][1] = randint(0,10);
        demand[i][1] = randint(0,10);

    set_txn_hash = flexCoin.transact().matching(supply, demand);
    chain.wait.for_receipt(set_txn_hash);

    matchResult = flexCoin.call().getMatching();
    print(matchResult)
