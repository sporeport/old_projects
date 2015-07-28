JournalApp.Views.PostForm = Backbone.View.extend({


  template: JST["posts/post_form"],

  events: {
    "submit form.post-form": "submitForm"
  },

  submitForm: function (event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON().post;
    this.model.save(formData, {
      success: function (data) {
        var postUrl = "#posts/" + this.model.id
        this.collection.add(this.model);
        Backbone.history.navigate(postUrl, {trigger: true})

      }.bind(this),
      error: function (model, jqxhr) {
        var $errors = $('<ul>');
        jqxhr.responseJSON.forEach(function (err) {
          $errors.append("<li>" + err + "</li>")
        });
      this.$el.prepend($errors)
      }.bind(this)
    });
  },

  render: function () {
    this.$el.html(this.template({ post: this.model }));
    return this;
  }
})
