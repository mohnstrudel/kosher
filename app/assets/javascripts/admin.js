//= require jquery/dist/jquery.min
//= require admin/bootstrap.min
//= require_tree ../../../vendor/assets/javascripts/admin/plugins/metisMenu/.
//= require_tree ../../../vendor/assets/javascripts/admin/plugins/slimscroll/.

// Flot
//= require admin/plugins/flot/jquery.flot
//= require admin/plugins/flot/jquery.flot.pie
//= require admin/plugins/flot/jquery.flot.resize
//= require admin/plugins/flot/jquery.flot.spline
//= require admin/plugins/flot/jquery.flot.symbol
//= require admin/plugins/flot/jquery.flot.time
//= require admin/plugins/flot/jquery.flot.tooltip.min
//= require admin/plugins/flot/curvedLines
//= require admin/plugins/flot/excanvas.min

// Peity
//= require_tree ../../../vendor/assets/javascripts/admin/plugins/peity/.
//= require admin/peity-demo

// Custom
//= require admin/inspinia
//= require_tree ../../../vendor/assets/javascripts/admin/plugins/pace/.

// Jasny file upload
//= require admin/plugins/jasny/jasny-bootstrap.min

// Select 2 plugin
//= require admin/plugins/select2/select2.full.min


// Jquery UI
//= require rails-ujs
//= require_tree ../../../vendor/assets/javascripts/admin/plugins/jquery-ui/.

// GRITTER
//= require_tree ../../../vendor/assets/javascripts/admin/plugins/gritter/.

// Sparkline
//= require_tree ../../../vendor/assets/javascripts/admin/plugins/sparkline/.

// TOASTER
//= require_tree ../../../vendor/assets/javascripts/admin/plugins/toastr/.

// Datapicker
//= require_tree ../../../vendor/assets/javascripts/admin/plugins/datapicker/.

// REMOVED turbolinks

//= require bootstrap-tagsinput

//= require markdown/lib/markdown
//= require bootstrap-markdown

// iCHECKBOX
//= require admin/plugins/icheck/icheck.min

//= require_tree ../../../app/assets/javascripts/admin/.





$(document).ready(function () {
    $('.i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
});