Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li.poke-list-item": "selectPokemonFromList"
  },

  initialize: function () {
    this.listenTo(this.collection, "sync add", this.render);
  },

  addPokemonToList: function (pokemon) {
    var content = JST["pokemonListItem"]({ pokemon: pokemon });
    this.$el.append(content);
  },

  refreshPokemon: function (options) {
    this.collection.fetch({success: options});
  },

  render: function () {
    this.$el.empty();
    this.collection.each( this.addPokemonToList.bind(this) );

    return this;
  },

  selectPokemonFromList: function (event) {
    var $target = $(event.currentTarget);
    var pokeId = $target.data('id');

    Backbone.history.navigate("pokemon/"+ pokeId, { trigger: true });
  }

});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys > li": "selectToyFromList"
  },

  refreshPokemon: function (options) {
    this.model.fetch({ success: this.render.bind(this) });
  },

  render: function () {
    var content = JST["pokemonDetail"]({ pokemon: this.model });
    this.$el.html(content);

    this.model.toys().each( function (toy) {
      var toys = JST["toyListItem"]({toy: toy});
      this.$el.find(".toys").append(toys);
    }.bind(this));

    return this;
  },

  selectToyFromList: function (event) {
    var toyId = $(event.currentTarget).data("id");
    var pokemonId = $(event.currentTarget).data("pokedex-id");
// TO DO
    //Backbone.history.navigate("pokemon/" + pokemonId/)
    var toy = this.model.toys().get(toyId);
    var toyDetail = new Pokedex.Views.ToyDetail({ model: toy});

    $(".toy-detail").html(toyDetail.render().$el);
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {

    var content = JST["toyDetail"]({ toy: this.model, pokes: Pokedex.pokes });
    this.$el.html(content);
    return this;
  }
});


// $(function () {
//   Pokedex.pokes = new Pokedex.Collections.Pokemon();
//   var pokemonIndex = new Pokedex.Views.PokemonIndex({ collection: Pokedex.pokes });
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });










//
// $(function () {
//   var myFunc = function () {
//     // does awesome stuff
//   };
//
//   window.moMoney = {};
//   window.moMoney.fn1 = myFunc;
//   window.$$ = window.moMoney;
//
//
//   window._ = function (obj) {
//     if (typeof obj === "Array") {
//       return new _Array(obj);
//     }
//   };
//
//   _Array = fucntion (array) {
//     this.array = array;
//   };
//
//   _Array.prototype.each = function () {
//     for (var i = 0)
//   };
//
//   var _ = window._;
//
//   _.each = function (iterator, iteratee) {
//     for (var i in iterator) {
//       var el = iterator[i];
//       iteratee(el)
//     }
//   }
//
// });
//
// _.each([], fucntion () {});
//
// _(list).each (function {})
