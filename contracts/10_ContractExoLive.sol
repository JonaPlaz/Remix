// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

contract ContractExoLive {
    address public myAddress;

    modifier fundsEnoughProvided() {
        require(msg.value > 1, "Not enough funds provided");
        _;
    }

    function setMyAddress(address _myAddress) external {
        myAddress = _myAddress;
    }

    function getBalance() external view returns (uint256) {
        return myAddress.balance;
    }

    function getBalanceOfAddress(address _address)
        external
        view
        returns (uint256)
    {
        return _address.balance;
    }

    // function payable car elle va recevoir de l'argent, address aussi en payable car la fonction va lui envoyer de l'argent
    // transfer
    function sendViaTransfer(address payable _to)
        external
        payable
        fundsEnoughProvided
    {
        _to.transfer(msg.value);
    }

    // send
    // permet de récupérer l'info quand ça revert à Transfer
    function sendViaSend(address payable _to)
        external
        payable
        fundsEnoughProvided
    {
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    // call
    // permet de récupérer l'info quand ça revert contrairement à Transfer
    // call permet d'exécuter une fonction pour récupérer des datas
    // call est moins safe parce que pas de limite de gas
    // c'est la plus utilisée car le cout de gas peut changer, du coup une fonction Send ou Transfer peut devenir obsolète à cause de la limite de 2300 de gas
    function sendViaCall(address payable _to)
        external
        payable
        fundsEnoughProvided
    {
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    function sendIfEnoughEthers(uint256 _minBalance)
        external
        payable
        fundsEnoughProvided
    {
        require(myAddress.balance > _minBalance, "Revert");
        (bool sent, ) = payable(myAddress).call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    receive() external payable {}

    fallback() external payable {}
}
