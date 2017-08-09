# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  setTimeout (->
    $('.alert-message').remove()
    return
  ), 5000
  $('.dropdown-toggle').dropdown()
  if $.fn.dataTable.isDataTable('table[data-datatable]')
    $('table[data-datatable]').DataTable()
  else
    $('table[data-datatable]').dataTable
      ordering: true
      columnDefs: [ {
        orderable: false
        targets: 'no-sort'
      } ]
      pagingType: 'full_numbers'
      dom: '<"top"f>rt<"bottom"lp>'
  return

$(document).ready ready
$(document).on 'turbolinks:load', ready