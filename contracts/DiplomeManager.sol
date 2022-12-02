// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract DiplomeManager {

  event EtudiantCreated(string _EtudiantName);
  event DiplomeAdd(string _EtudiantName, string _DiplomeName);
  event getDiplomes(Diplome[] _Diplomes);

  struct Diplome {
    string diplomeName;
    string dateObtention;
    string etablissement;
    string mention;
  }

  struct Etudiant{
    string _EtudiantName;
    string _EtudiantLastName;
    string _EtudiantEmail;
    address _EtudiantAddress;
    Diplome[] _Diplomes;
  }

  uint mapSize;

  mapping(address => Etudiant) public Etudiants;

  address owner;

  constructor() {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "Seul le proprio peut faire cela");
    _;
  }

  function createEtudiant(address _EtudiantAddress, string memory _EtudiantName, string memory _EtudiantLastName, string memory _EtudiantEmail) external returns (string memory) {
    require(bytes(Etudiants[_EtudiantAddress]._EtudiantName).length == 0, "L'etudiant existe deja");
    Etudiants[_EtudiantAddress]._EtudiantName = _EtudiantName;
    Etudiants[_EtudiantAddress]._EtudiantLastName = _EtudiantLastName;
    Etudiants[_EtudiantAddress]._EtudiantEmail = _EtudiantEmail;
    Etudiants[_EtudiantAddress]._EtudiantAddress = _EtudiantAddress;
    emit EtudiantCreated(Etudiants[_EtudiantAddress]._EtudiantName);
  }

  function addDiplome(address _EtudiantAddress, string memory _diplomeName, string memory _dateObtention, string memory _etablissement, string memory _mention) external{
      require(bytes(Etudiants[_EtudiantAddress]._EtudiantName).length > 0, "L'etudiant n'existe pas");
      Diplome memory newDiplome = Diplome(_diplomeName, _dateObtention, _etablissement,_mention);
      Etudiants[_EtudiantAddress]._Diplomes.push(newDiplome);
      emit DiplomeAdd(Etudiants[_EtudiantAddress]._EtudiantName, _diplomeName);
  }

  //---------------------------------- GETTERS ----------------------------------//

  function getEtudiantsByAddress(address _EtudiantAddress) external view returns (Etudiant memory) {
    return Etudiants[_EtudiantAddress];
  }

  function getDiplomesEtudiantLength(address _EtudiantAddress) external view returns (uint){
    return Etudiants[_EtudiantAddress]._Diplomes.length;
  }

   function getDiplomesEtudiant(address _EtudiantAddress, uint nbDip) external view returns (Diplome memory){
    return Etudiants[_EtudiantAddress]._Diplomes[nbDip];
  }

  function getAllDiplomes(address _EtudiantAddress) external view returns (Diplome[] memory){
    return Etudiants[_EtudiantAddress]._Diplomes;
  }


}