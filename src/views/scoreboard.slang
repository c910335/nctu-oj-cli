doctype html
html
  head
    title Introduction to Algorithms 2019 Fall Scoreboard
    link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css"
    link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"
    meta name="viewport" content="width=device-width, initial-scale=1.0"
    css:
      thead tr th { position: -webkit-sticky; position: sticky; top: 0; }
      tbody tr th { position: -webkit-sticky; position: sticky; left: 0; text-align: center; }
      tbody { overflow-x: auto; white-space: nowrap; }
      td { min-width: 100px; }
  body
    .container.center-align
      h2 Scoreboard
      h3 Introduction to Algorithms 2019 Fall 
      p Generated at #{::Time.local}
      table class="highlight centered"
        thead
          td
          - problems.each do |p|
            th.white
              a target="_blank" href="https://oj.nctu.me/problems/#{p.id}/" = p.id
          th.white Total
        tbody
          - judges.each_with_index do |judge, i|
            tr
              th.white = users[i].name
              - judge.each_with_index do |r, j|
                - if r
                  td.green.lighten-3
                    a target="_blank" href="https://oj.nctu.me/groups/#{group_id}/submissions/?count=99999&name=#{users[i].name}&problem_id=#{problems[j].id}"
                      i.material-icons done
                - elsif r.is_a? Bool
                  td.red.lighten-3
                    a target="_blank" href="https://oj.nctu.me/groups/#{group_id}/submissions/?count=99999&name=#{users[i].name}&problem_id=#{problems[j].id}"
                      i.material-icons clear
                - else
                  td
              td = totals[i]
