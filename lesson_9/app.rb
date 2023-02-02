# frozen_string_literal: true

# Изначальный код взят из 8 урока
# Задание:
# 1. Написать модуль, содержащий 2 метода, которые можно вызывать на уровне класса:
# 1.1 attr_accessor_with_history
# Динамически создает геттеры и сеттеры для любого количества атрибутов.
# При этом сеттер сохраняет все значения инстанс-переменной при изменении
# этого значения.
# Также должен быть метод <имя_атрибута>_history, который возвращает массив
# всех значений данной переменной.

require_relative 'modules/interface'

include Interface

Interface.start
