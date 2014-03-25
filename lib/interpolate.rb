class Interpolate
  def self.zerofill(from, to, step, data)
    from = from.to_i
    to   = to.to_i
    step = step.to_i

    interpolated = []
    current      = from + step

    data.each do |d|
      time = d.first
      val  = d.last

      nearest = self.coerce_to_nearest(time, step)
      next if interpolated.last && interpolated.last.first == nearest

      (current...nearest).step(step) { |i| interpolated.push([i, 0]) }
      interpolated.push([nearest, val])

      current = nearest + step
    end

    (current...to).step(step) { |i| interpolated.push([i, 0]) }

    interpolated
  end

  def self.coerce_to_nearest(time, step)
    nearest = time
    res     = time.modulo(step)

    if res <= step * 0.5
      time.div(step) * step
    else
      time.div(step) * step + step
    end
  end
end
