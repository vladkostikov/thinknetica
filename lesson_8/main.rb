# frozen_string_literal: true

# Изначальный код взят из 7 урока
# 1. Просмотреть код проекта и попробовать применить рассмотренные идиомы там,
# где это возможно.
# 2. Исправить все ошибки (кроме отсутствия документации), которые выдаст rubocop.

require_relative 'modules/interface/interface'

include Interface

run_interface
