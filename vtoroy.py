import pandas as pd
import numpy as np
import os
import re

def preprocess_indexes(text):
    """ Извлекаем числовые значения и обрабатываем строку для дальнейшей классификации. """
    first_two_digits = re.findall(r'\d{2}', text)
    return float(first_two_digits[0]) if first_two_digits else None

def classify_by_length(row):
    """ Классификация на основе длины строки и текстовых данных. """
    index_length = len(row['ГРНТИ'].replace('.', ''))  # Убираем точки при подсчете длины
    if index_length == 8:
        # Классификация на основе индексов
        return f"Класс по индексу: {preprocess_indexes(row['ГРНТИ'])}"
    elif index_length == 18:
        # Текстовая классификация
        return classify_by_text(row['Прочие_данные'])

def classify_by_text(text):
    """ Классификация на основе ключевых слов в тексте. """
    if 'энергия' in text.lower():
        return 'Энергетические исследования'
    elif 'медицина' in text.lower():
        return 'Медицинские исследования'
    else:
        return 'Другая категория'

# Загрузка данных
os.chdir(r'D:\Хакатон')
df = pd.read_excel("ИКРБС_2020-2024_гг..xlsx")

# Применение классификации
df['Классификация'] = df.apply(classify_by_length, axis=1)
print(df[['ГРНТИ','Прочие_данные', 'Классификация']])
