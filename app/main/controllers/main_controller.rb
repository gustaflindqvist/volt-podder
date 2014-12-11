class MainController < Volt::ModelController
  reactive_accessor :_query

  def options
    return page._opts.to_s.or('').split(/,/)
  end

  def get_podcasts
    promise = LoggingTasks.log('Hello World from the server!')
    store._podcasts
  end

  def current_podcast
    store._podcasts[params._index.or(0).to_i]
  end

  def get_podcast_url podcast_id
    store._medias.find({podcast_id: podcast_id}).limit(5)
  end

  def formatDate string
    `new Date(Date.parse(#{string}))`
  end

  private

  # the main template contains a #template binding that shows another
  # template.  This is the path to that template.  It may change based
  # on the params._controller and params._action values.
  def main_path
    params._controller.or('main') + '/' + params._action.or('index')
  end
end
