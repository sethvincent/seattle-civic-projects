Handlebars.registerHelper 'makeFullURI', (uri) ->
  if uri == null
    return ''
  else if uri.substr(0,4) == 'http'
    return uri
  else
    return "http://#{uri}"

$ ->
  spreadsheet_url = 'https://app.flatsheet.io/api/v1/sheets/fltgr1f77g5tjmqnhcoviq'
  projects = []
  $project_listing = $('#project-listing')
  project_handlebars = $('#project-template').html()
  project_template = Handlebars.compile(project_handlebars)

  $.getJSON spreadsheet_url, (data) ->
    projects = data.rows

    # TODO: sorting and filtering and tag-cloudifying
    
    slice_size = 3
    for i in [0...projects.length] by slice_size
      projects_slice = projects[i...i+slice_size]
      $row = $('<div class="row"></div>')
      for project in projects_slice
        $row.append(project_template(project))
      $project_listing.append($row)
