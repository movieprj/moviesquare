mobiscroll.setOptions({
  lang: "ko",
  locale: mobiscroll.localeEn, // Specify language like: locale: mobiscroll.localePl or omit setting to use default
  theme: "ios", // Specify theme like: theme: 'ios' or omit setting to use default
  themeVariant: "light", // More info about themeVariant: https://docs.mobiscroll.com/5-27-3/range#opt-themeVariant
});

$(function () {
  // Mobiscroll Range initialization
  $("#demo-start-end")
    .mobiscroll()
    .datepicker({
      controls: ["calendar"], // More info about controls: https://docs.mobiscroll.com/5-27-3/range#opt-controls
      select: "range", // More info about select: https://docs.mobiscroll.com/5-27-3/range#methods-select
      display: "anchored", // Specify display mode like: display: 'bottom' or omit setting to use default
      startInput: "#demo-init-start", // More info about startInput: https://docs.mobiscroll.com/5-27-3/range#opt-startInput
      endInput: "#demo-init-end", // More info about endInput: https://docs.mobiscroll.com/5-27-3/range#opt-endInput
    });

  // Mobiscroll Range initialization
});
