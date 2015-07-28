JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "/posts",
  model: JournalApp.Models.Post,
  getOrFetch: function (id) {
    var model = this.get(id);

    if (model) {
      model.fetch();
    } else {
      model = new JournalApp.Models.Post({ id: id});
      model.fetch({ success: this.add.bind(this, model) })
    };

    return model;
  }
});
