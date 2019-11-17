doctype html
html
  head
    title = title
    link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css"
    link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"
    meta name="viewport" content="width=device-width, initial-scale=1.0"
    css:
      thead tr th { position: -webkit-sticky; position: sticky; top: 0; }
      tbody tr th { position: -webkit-sticky; position: sticky; left: 0; text-align: center; }
      tbody { overflow-x: auto; white-space: nowrap; }
      td { min-width: 100px; }
      .container { width: 90%; }
    - if refresh_period
      javascript:
        setTimeout(() => { location.reload() }, #{refresh_period * 60000});
  body
    .container.center-align
      h2 Scoreboard
      h3 = title
      p Generated at #{Time.local} by
        a target="_blank" href="https://github.com/c910335/nctu-oj-cli" GitHub
      - if message
        p = message
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
                  - if r >= 100
                    td.green.lighten-3
                      a target="_blank" href="https://oj.nctu.me/groups/#{group_id}/submissions/?count=99999&name=#{users[i].name}&problem_id=#{problems[j].id}"
                        - if judge_type == "pass"
                          i.material-icons done
                        - else
                          = r
                  - elsif r >= 30
                    td.yellow.lighten-3
                      a target="_blank" href="https://oj.nctu.me/groups/#{group_id}/submissions/?count=99999&name=#{users[i].name}&problem_id=#{problems[j].id}"
                        - if judge_type == "pass"
                          i.material-icons clear
                        - else
                          = r
                  - else
                    td.red.lighten-3
                      a target="_blank" href="https://oj.nctu.me/groups/#{group_id}/submissions/?count=99999&name=#{users[i].name}&problem_id=#{problems[j].id}"
                        - if judge_type == "pass"
                          i.material-icons clear
                        - else
                          = r
                - else
                  td
              td = student_totals[i]
          tr
            th.white Total
            - problem_totals.each do |t|
              td = t
