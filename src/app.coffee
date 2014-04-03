Handlebars.registerHelper 'makeFullURI', (uri) ->
  if uri.substr(0,4) == 'http'
    return uri
  else
    return "http://#{uri}"

$ ->
  spreadsheet_url = 'http://spreadsheets.google.com/feeds/list/0Ao0MEp85bWtGdEJ6alJDUWptTTlNbnN1TC03d1NMNlE/od6/public/values?alt=json-in-script'
  projects = []
  $project_listing = $('#project-listing')
  project_handlebars = $('#project-template').html()
  project_template = Handlebars.compile(project_handlebars)

  $.getJSON spreadsheet_url + '&callback=?', (data) ->
    $.each data.feed.entry, (index, project) ->
      projects.push({
        name: project.gsx$name.$t
        code_url: project.gsx$codeurl.$t
        public_url: project.gsx$publicurl.$t
        description: project.gsx$description.$t
        status: project.gsx$devstatus.$t
        contributors: project.gsx$contributors.$t
        notes: project.gsx$notes.$t
        project_tags: project.gsx$projecttags.$t.split(',')
        technology_tags: project.gsx$technologytags.$t.split(',')
        thumbnail_url: project.gsx$screenshoturl.$t
        last_update: project.gsx$lastupdate.$t
      })

    # TODO: sorting and filtering and tag-cloudifying
    
    slice_size = 3
    for i in [0...projects.length] by slice_size
      projects_slice = projects[i...i+slice_size]
      $row = $('<div class="row"></div>')
      for project in projects_slice
        $row.append(project_template(project))
      $project_listing.append($row)
