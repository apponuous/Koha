<script type="text/javascript">
//<![CDATA[
/* Instead of including multiple localization files as you would normally see with
   jQueryUI we expose the localization strings in the default configuration */
jQuery(function($){
    $.datepicker.regional[''] = {
        closeText: _('Done'),
        prevText: _('Prev'),
        nextText: _('Next'),
        currentText: _('Today'),
        monthNames: [_('January'),_('February'),_('March'),_('April'),_('May'),_('June'),
        _('July'),_('August'),_('September'),_('October'),_('November'),_('December')],
        monthNamesShort: [_('Jan'), _('Feb'), _('Mar'), _('Apr'), _('May'), _('Jun'),
        _('Jul'), _('Aug'), _('Sep'), _('Oct'), _('Nov'), _('Dec')],
        dayNames: [_('Sunday'), _('Monday'), _('Tuesday'), _('Wednesday'), _('Thursday'), _('Friday'), _('Saturday')],
        dayNamesShort: [_('Sun'), _('Mon'), _('Tue'), _('Wed'), _('Thu'), _('Fri'), _('Sat')],
        dayNamesMin: [_('Su'),_('Mo'),_('Tu'),_('We'),_('Th'),_('Fr'),_('Sa')],
        weekHeader: _('Wk'),
        dateFormat: '[% IF ( dateformat_us ) %]mm/dd/yy[% ELSIF ( dateformat_metric ) %]dd/mm/yy[% ELSE %]yy-mm-dd[% END %]',
        firstDay: [% CalendarFirstDayOfWeek %],
        isRTL: [% IF ( bidi ) %]true[% ELSE %]false[% END %],
        showMonthAfterYear: false,
        yearSuffix: ''};
    $.datepicker.setDefaults($.datepicker.regional['']);
});

$(document).ready(function(){

$.datepicker.setDefaults({
        showOn: "both",
        changeMonth: true,
        changeYear: true,
        buttonImage: '[% interface %]/[% theme %]/img/famfamfam/silk/calendar.png',
        buttonImageOnly: true,
        showButtonPanel: true,
        showOtherMonths: true,
        selectOtherMonths: true
    });

    $( ".datepicker" ).datepicker();
    // http://jqueryui.com/demos/datepicker/#date-range
    var dates = $( ".datepickerfrom, .datepickerto" ).datepicker({
        changeMonth: true,
        numberOfMonths: 1,
        onSelect: function( selectedDate ) {
            var option = this.id == "from" ? "minDate" : "maxDate",
                instance = $( this ).data( "datepicker" );
                date = $.datepicker.parseDate(
                    instance.settings.dateFormat ||
                    $.datepicker._defaults.dateFormat,
                    selectedDate, instance.settings );
            dates.not( this ).datepicker( "option", option, date );
        }
    });
});
//]]>
</script>