function initializeDateRangePicker() {
  $(function() {
    $('input[name="course[start_date]"]').daterangepicker({
      timePicker: true,
      startDate: moment().startOf('hour'),
      endDate: moment().startOf('hour').add(1, 'week'),
      locale: {
        format: 'M/DD/YYYY hh:mm A'
      }
    });
  });
}

export { initializeDateRangePicker }
