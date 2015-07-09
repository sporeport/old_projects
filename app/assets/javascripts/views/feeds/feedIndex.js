NewsReader.Views.FeedIndex = Backbone.View.extend({

  template: JST["feeds/index"],
  events: {
    "click button.feed-delete":"deleteFeed",
    "submit .feed-add":"addFeed"
  },

  initialize: function () {
    this.listenTo(this.collection, "sync remove add", this.render)
  },

  render: function(){
    var feed = new NewsReader.Models.Feed();
    this.$el.html(this.template({ feedForm: feed, feeds: this.collection }));
    return this;
  },

  deleteFeed: function (event) {
    var feedId = $(event.currentTarget).data("id");
    this.collection.get(feedId).destroy();
    // this.collection.remove(feedId);
  },

  addFeed: function(event){
    event.preventDefault();
    var feedParams = $(event.currentTarget).serializeJSON()["feed"];

    var newFeed = new NewsReader.Models.Feed(feedParams);
    newFeed.save([], {
      reset: true,
      success: function(model) {
        this.collection.add(model)
      }.bind(this)
      });
  }
})
