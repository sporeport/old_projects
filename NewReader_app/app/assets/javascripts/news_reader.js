window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var router = new NewsReader.Routers.NewsRouter({ $rootEl: $("#content") });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
