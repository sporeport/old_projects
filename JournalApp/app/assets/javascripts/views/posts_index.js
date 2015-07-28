JournalApp.Views.PostsIndex = Backbone.View.extend({

  initialize: function() {
    this.listenTo(this.collection, "remove reset", this.render.bind(this));
  },

  template: JST['posts/index'],


  render: function () {
    this.$el.html(this.template());

    this.collection.each( function (model) {
      var indexItemView =
            new JournalApp.Views.PostsIndexItem({ model: model });
      this.$el.find(".posts-index").append(indexItemView.render().$el);
    }.bind(this))

    return this;
  }
});
