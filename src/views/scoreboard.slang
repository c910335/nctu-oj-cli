doctype html
html
  head
    title = title
    link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css"
    link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"
    meta name="viewport" content="width=device-width, initial-scale=1.0"
    meta charset="utf-8"
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
              a target="_blank" href="https://oj.nctu.edu.tw/problems/#{p.id}/" = p.id
              - if weight = p.weight
                sub = "#{(weight * 100).to_i}%"
          th.white Total
        tbody
          - judges.each_with_index do |judge, i|
            tr
              th.white = aliases.try(&.[users[i].name]?) || users[i].name
              - judge.each_with_index do |r, j|
                - if r
                  - if r >= 100
                    td.green.lighten-3
                      a target="_blank" href="https://oj.nctu.edu.tw/groups/#{group_id}/submissions/?count=99999&name=#{users[i].name}&problem_id=#{problems[j].id}"
                        - if judge_type == "pass"
                          i.material-icons done
                        - else
                          = r
                  - elsif r >= 30
                    td.yellow.lighten-3
                      a target="_blank" href="https://oj.nctu.edu.tw/groups/#{group_id}/submissions/?count=99999&name=#{users[i].name}&problem_id=#{problems[j].id}"
                        - if judge_type == "pass"
                          i.material-icons clear
                        - else
                          = r
                  - else
                    td.red.lighten-3
                      a target="_blank" href="https://oj.nctu.edu.tw/groups/#{group_id}/submissions/?count=99999&name=#{users[i].name}&problem_id=#{problems[j].id}"
                        - if judge_type == "pass"
                          i.material-icons clear
                        - else
                          = r
                - else
                  td
              td = student_totals[i]
          tr
            th.white AC
            - problem_acs.each do |a|
              td = a
          - unless judge_type == "pass"
            tr
              th.white Max
              - problem_maxes.not_nil!.each do |m|
                td = m
            tr
              th.white Mean
              - problem_means.not_nil!.each do |m|
                td = "%.2f" % m
            tr
              th.white Median
              - problem_medians.not_nil!.each do |m|
                td = m
            tr
              th.white Standard Deviation
              - problem_sds.not_nil!.each do |s|
                td = "%.2f" % s
