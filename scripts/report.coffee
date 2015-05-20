# Description
#   Reports JSON data from a remote URL
#
# Commands:
#   hubot report <report name> - Fetch clippings.com/report/<report_name>.json and converts it to text.
#   hubot report list - List available reports.

process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0"

module.exports = (robot) ->

  robot.respond /report (.*)/i, (res) ->
    report = res.match[1].replace(' ', '_')
    res.reply 'Fetching your report...'
    robot.http('https://clippings.com/report/' + report + '.json')
      .get() (err, response, body) ->
        if err
          res.send 'No such report'
          return

        data = JSON.parse body
        unless Array.isArray data
          data = for own key, value of data
            "#{key}: #{value}"

        res.send data.join "\n"




