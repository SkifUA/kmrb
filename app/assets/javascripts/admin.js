// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require cable
//= require_directory ./bootstrap
//= require_directory ./admin


var ready = function() {
    setTimeout(function() {
        $('.alert-message').remove();
    }, 5000);

    if ( $.fn.dataTable.isDataTable('table[data-datatable]') ) {
        $('table[data-datatable]').DataTable();
    }
    else {
        $('table[data-datatable]').dataTable( {
            paginate: false,
            ordering: true,
            columnDefs: [{
                orderable: false,
                targets: 'no-sort'
            }]
        } );
    }
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);