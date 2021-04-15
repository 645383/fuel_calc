# frozen_string_literal: true

require_relative "fuel_calc/version"

module FuelCalc
  class << self
    def fuel_calculate(mass, mission)
      dif = mass
      mission.each do |m|
        res = 0
        res += calc(mass, m[1], m[0])
        mass += res
      end
      mass -= dif
    end

    private

    def launch(mass, gravity)
      (mass * gravity * 0.033 - 42).floor
    end

    def land(mass, gravity)
      (mass * gravity * 0.042 - 33).floor
    end

    def calc(mass, gravity, type)
      if (type == :launch)
        res = launch(mass, gravity)
        if (res > 0)
          return res + calc(res, gravity, type)
        else
          return 0
        end
      end
      if (type == :land)
        res = land(mass, gravity)
        if (res > 0)
          return res + calc(res, gravity, type)
        else
          return 0
        end
      end
    end
  end
end
