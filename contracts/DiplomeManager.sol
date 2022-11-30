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
  }

  struct Etudiant{
    string _EtudiantName;
    Diplome[] _Diplomes;
  }

  mapping(address => Etudiant) public Etudiants;

  address owner;

  constructor() {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "Seul le proprio peut faire cela");
    _;
  }

  function createEtudiant(address _EtudiantAddress, string memory _EtudiantName) external {
    require(bytes(Etudiants[_EtudiantAddress]._EtudiantName).length == 0, "L'etudiant existe deja");
    Etudiants[_EtudiantAddress]._EtudiantName = _EtudiantName;
    emit EtudiantCreated(_EtudiantName);
  }

  function addDiplome(address _EtudiantAddress, string memory _diplomeName, string memory _dateObtention, string memory _etablissement) external{
      require(bytes(Etudiants[_EtudiantAddress]._EtudiantName).length > 0, "L'etudiant n'existe pas");
      Diplome memory newDiplome = Diplome(_diplomeName, _dateObtention, _etablissement);
      Etudiants[_EtudiantAddress]._Diplomes.push(newDiplome);
      emit DiplomeAdd(Etudiants[_EtudiantAddress]._EtudiantName, _diplomeName);
  }

  //---------------------------------- GETTERS ----------------------------------//

  function getDiplomesEtudiantLength(address _EtudiantAddress) external view returns (uint){
    return Etudiants[_EtudiantAddress]._Diplomes.length;
  }

   function getDiplomesEtudiant(address _EtudiantAddress, uint nbDip) external view returns (string memory){
    return Etudiants[_EtudiantAddress]._Diplomes[nbDip].diplomeName;
  }

  function getEtudiant(address _EtudiantAddress) external view returns (string memory) {
    return Etudiants[_EtudiantAddress]._EtudiantName;
  }
}