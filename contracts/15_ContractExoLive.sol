// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

contract ContractExoLive6 {
    struct Apprenant {
        string name;
        uint256 note;
    }

    // uint[2][3] se lit à l'envers 3 : première dimension et 2 : deuxième dimension

    Apprenant[] apprenants;

    function addApprenant(string memory _name, uint256 _note) external {
        Apprenant memory newApprenant = Apprenant({name: _name, note: _note});
        apprenants.push(newApprenant);
    }
}

contract ContractExoLive61 {
    uint256[] public nombres;

    function addNombres(uint256 _nombre) public {
        nombres.push(_nombre);
    }

    function deleteValue(uint256 _index) public {
        delete nombres[_index]; // met la valeur à 0 mais ne supprime pas l'index
    }
}

contract ContractExoLive62 {
    uint256[] public nombres;

    function addNombres(uint256 _nombre) public {
        nombres.push(_nombre);
    }

    function getNombresX2() external view returns (uint256[] memory) {
        uint256 longueurTableau = nombres.length;
        // il faut indiquer la longueur du tableau pour un memory
        uint256[] memory nombresX2 = new uint256[](longueurTableau);
        for (uint256 i = 0; i < longueurTableau; i++) {
            nombresX2[i] = nombres[i] * 2;
        }
        return nombresX2;
    }

    function sommeTableau(uint256[] memory monTableau)
        external
        pure
        returns (uint256)
    {
        uint256 res;
        for (uint256 i = 0; i < monTableau.length; i++) {
            res += monTableau[i];
        }
        return res;
    }
}

contract ContractExoLive63 {
    enum etape {
        commande,
        expedie,
        livre
    }

    struct Produit {
        uint256 _SKU;
        etape _etape;
    }

    mapping(address => Produit) public CommandesClients;

    function command(uint _SKU) external {
        Produit memory p = Produit(_SKU, etape.commande);
        CommandesClients[msg.sender] = p;
    }
}
