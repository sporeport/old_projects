NewsReader.Routers.NewsRouter = Backbone.Router.extend({
  routes: {
    "": "feedsIndex",
    "feeds/:id": "feedShow"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl

    this.currentUser ( function () {
      if(this._currentUser){
        var navBar = new NewsReader.Views.UserShow();
      } else {
        var navBar = new NewsReader.Views.UserForm();
      }
      $("#nav-bar").append(navBar.render().$el);
    }.bind(this))

    this.feeds = new NewsReader.Collections.Feeds();
  },

  currentUser: function (callback) {
    if(!this._currentUser){
      var currentUser = new NewsReader.Models.CurrentUser();
      currentUser.fetch({
        success: function (model) {
          this._currentUser = new NewsReader.Models.User(model);
          callback();
        }.bind(this),
        error: function () {
          callback();
        }.bind(this)
      })
    }

    return this._currentUser
  },

  feedsIndex: function () {
    var feedIndex = new NewsReader.Views.FeedIndex({ collection: this.feeds });
    this.swapView(feedIndex);
    this.feeds.fetch();
  },

  feedShow: function (id) {
    var feed = this.feeds.getOrFetch(id);
    var feedShow = new NewsReader.Views.FeedShow({ model: feed });
    this.swapView(feedShow);
  },

  swapView: function (newView) {
    if (this._currentView){
      this._currentView.remove();
    }
    this._currentView = newView;
    this.$rootEl.html(this._currentView.render().$el);
  }

})
