# name, code_url, dev_status, public_url, last_update, people, notes
# gsx$name, gsx$codeurl, gsx$devstatus, gsx$publicurl, gsx$lastupdate, gsx$people, gsx$notes

$ ->
  spreadsheet_url = 'http://spreadsheets.google.com/feeds/list/0Ao0MEp85bWtGdEJ6alJDUWptTTlNbnN1TC03d1NMNlE/od6/public/values?alt=json-in-script'
  window.projects = []
  $.getJSON spreadsheet_url + '&callback=?', (data) ->
    $.each data.feed.entry, (index, entry) ->
      projects.push({
        name: entry.gsx$name.$t
        code_url: entry.gsx$codeurl.$t
        dev_status: entry.gsx$devstatus.$t
        public_url: entry.gsx$publicurl.$t
        last_update: entry.gsx$lastupdate.$t
        contributors: entry.gsx$people.$t
        notes: entry.gsx$notes.$t
        tags: ''
      })

