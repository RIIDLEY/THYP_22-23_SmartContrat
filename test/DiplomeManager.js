const DiplomeManager = artifacts.require("DiplomeManager");

contract("DiplomeManager", accounts => {

    it("cela devrait creer un etudiant", async () => {
        const Contract = await DiplomeManager.deployed();
        const result = await Contract.createEtudiant("0xcc332b9427fd3bd8d918bf6d91fd7cdda21606a7","Lahoucine",{from: accounts[0]});
        assert.equal(result.logs[0].args._EtudiantName, "Lahoucine", "Le nom de l'etudiant n'est pas correct");
    })

    it("Cela ne devrait pas creer un etudiant", async () => {
        const Contract = await DiplomeManager.deployed();
        try {
            await Contract.createEtudiant("0xcc332b9427fd3bd8d918bf6d91fd7cdda21606a7","Lahoucine",{from: accounts[0]});
        } catch (error) {
            assert(error.toString().includes('revert'), error.toString());
        }
    })

    it("cela devrait creer un diplome", async () => {
        const Contract = await DiplomeManager.deployed();
        const result = await Contract.addDiplome("0xcc332b9427fd3bd8d918bf6d91fd7cdda21606a7","Master 2 THYP","12/11/2022","Universite Paris 8",{from: accounts[0]});
        assert.equal(result.logs[0].args._DiplomeName, "Master 2 THYP", "Une errreure est survenue");
    })

    it("Cela ne devrait pas ajouter un diplome à un etudiant qui n'existe pas", async () => {
        const Contract = await DiplomeManager.deployed();
        try {
            await Contract.addDiplome("0xd09dfda7831e5c000e8f9b7d4bec2ffb40c7bab3","Master 2 THYP","12/11/2022","Universite Paris 8",{from: accounts[0]});
        } catch (error) {
            assert(error.toString().includes('revert'), error.toString());
        }
    })

    it("Cela devrait retourner le diplome d'un étudiant", async () => {
        const Contract = await DiplomeManager.deployed();
        const result = await Contract.getDiplomesEtudiant("0xcc332b9427fd3bd8d918bf6d91fd7cdda21606a7");
        assert.equal(result.logs[0].args._Diplomes[0].diplomeName, "Master 2 THYP", "Une errreure est survenue");
    })
})