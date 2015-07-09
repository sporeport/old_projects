NewsReader.Routers.NewsRouter = Backbone.Router.extend({
  routes: {
    "": "feedsIndex",
    "feeds/:id": "feedShow"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl
    this.feeds = new NewsReader.Collections.Feeds();
  },

  feedsIndex: function () {
    var feedIndex = new NewsReader.Views.FeedIndex({ collection: this.feeds });
    this.$rootEl.html(feedIndex.render().$el)
    this.feeds.fetch()
  },

  feedShow: function (id) {
    var feed = this.feeds.getOrFetch(id);
    var feedShow = new NewsReader.Views.FeedShow({ model: feed });
    this.$rootEl.html(feedShow.render().$el);
  }

})
