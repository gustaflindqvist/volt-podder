class MainController < Volt::ModelController
  reactive_accessor :_query

  def options
    return page._opts.to_s.or('').split(/,/)
  end

  def get_podcasts
    store._podcasts
  end

  def current_podcast
   store._podcasts[params._index.or(0).to_i]
  end

  def formatCurrentDate current_date
    r = current_date.match('^\d{4}-\d{2}-\d{2}')[0] if current_date.nil?
    d = r[0]
    d
  end

  private

  # the main template contains a #template binding that shows another
  # template.  This is the path to that template.  It may change based
  # on the params._controller and params._action values.
  def main_path
    params._controller.or('main') + '/' + params._action.or('index')
  end
end
