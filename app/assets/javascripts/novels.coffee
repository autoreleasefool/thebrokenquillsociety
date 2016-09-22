totalWorkFields = 1

addWorkField = ->
  totalWorkFields += 1

  dropdown = $('select[id^="work-dropdown-"]:last')
  id = parseInt(dropdown.prop('id').match(/\d+/g), 10) + 1
  dropdownClone = dropdown.clone().prop('id', 'work-dropdown-' + id)
  dropdownClone.on 'change', (e) ->
    updateDisabledFields()

  label = $('label[id^="chapter-label-"]:last')
  id = parseInt(label.prop('id').match(/\d+/g), 10) + 1
  labelClone = label.clone().prop('id', 'chapter-label-' + id)
  labelClone.html('Chapter' + totalWorkFields)

  $('#work-dropdowns').append(labelClone)
  $('#work-dropdowns').append(dropdownClone)

updateDisabledFields = ->
  dropdowns = $('select[id^="work-dropdown-"]').toArray()
  for i in [1..totalWorkFields] # For each work dropdown
    dropdown = $('#work-dropdown-' + i) # Get the dropdown by id
    currentWorkId = dropdown.val() # Get its current value
    if currentWorkId != '' # If the value isn't blank
      for j in [1..totalWorkFields] # Loop through each other dropdown
        if j != i # Don't do anything for the same dropdown
          secondaryDropdown = $('#work-dropdown-' + j)

          # Disable the current id being checked, set the value to blank if it had the same value
          secondaryDropdown.find('option[value="' + currentWorkId + '"]').attr('disabled', 'disabled')
          if secondaryDropdown.val() == currentWorkId
            secondaryDropdown.val('')

# On document ready
$ ->

  updateDisabledFields()

  if $('#add-work-btn').length
    $('#add-work-btn').on 'click', (e) ->
      e.preventDefault()
      addWorkField()
      updateDisabledFields()

  $('.work-dropdown').on 'change', (e) ->
    updateDisabledFields()
