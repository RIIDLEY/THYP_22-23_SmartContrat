const FavoriteNumber = artifacts.require("FavoriteNumber");

contract("FavoriteNumber", accounts => {
  it("...should store the value 89.", async () => {
    const FavoriteNumberInstance = await FavoriteNumber.deployed();
    const resultat = await FavoriteNumberInstance.setFavoriteNumber(89, { from: accounts[0] });

  })

    it("...should get the value 89.", async () => {
        const FavoriteNumberInstance = await FavoriteNumber.deployed();
        const number = await FavoriteNumberInstance.getFavoriteNumber.call();
        console.log(number);
        assert.equal(number.words[0], 89, "The value 89 was not stored.");
    })
})