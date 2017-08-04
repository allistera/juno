//= require cable
//= require_self
//= require_tree .

this.App = {};
App.cable = ActionCable.createConsumer();

App.messages = App.cable.subscriptions.create('SiteChannel', {
    received: function(data) {
        console.log(data.status)
        if (data.status === 'active') {
            var css_class = 'is-success';
        }else if (data.status === 'inactive') {
            var css_class = 'is-danger';
        }else{
            var css_class = 'is-light';
        }
        $('.site-status-' + data.site).removeClass('is-light is-success is-danger').addClass(css_class)
    }
});