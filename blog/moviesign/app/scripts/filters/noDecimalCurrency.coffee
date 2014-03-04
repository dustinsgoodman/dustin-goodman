'use strict'

angular.module('dashboardApp')
  .filter 'noDecimalCurrency', ['$filter', '$locale', ($filter, $locale) ->
    currencyFilter = $filter('currency')
    formats = $locale.NUMBER_FORMATS
    (amt, symbol) ->
      value = currencyFilter(amt, symbol)
      sep = value.indexOf(formats.DECIMAL_SEP)
      if amt >= 0
        return value.substring(0, sep)
      return "-#{value.substring(1,sep)}"
  ]
