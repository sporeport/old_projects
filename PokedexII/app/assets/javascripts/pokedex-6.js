Pokedex.Router = Backbone.Router.extend({
  routes: {
    '': 'pokemonIndex',
    'pokemon/:id' : 'pokemonDetail',
    'pokemon/:pokemonId/toys/:toyId' : 'toyDetail'
  },

  pokemonDetail: function (id, callback) {
    if (!this._pokemonIndex){
      this.pokemonIndex( function(event) {
        this.pokemonDetail(id);
      }.bind(this));
    } else {
      var pokemon = this._pokemonIndex.collection.get(id);
      var pokemonDetail = new Pokedex.Views.PokemonDetail({ model: pokemon});
      pokemonDetail.refreshPokemon();
      $("#pokedex .pokemon-detail").html(pokemonDetail.render().$el);
    };
  },

  pokemonIndex: function (callback) {
    pokes = new Pokedex.Collections.Pokemon();
    this._pokemonIndex = new Pokedex.Views.PokemonIndex({ collection: pokes });
    this._pokemonIndex.refreshPokemon(callback);
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
  },

  toyDetail: function (pokemonId, toyId) {
  },

  pokemonForm: function () {
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
