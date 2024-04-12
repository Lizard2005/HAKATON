import pandas as pd
import numpy as np
import os

# Установка рабочей директории
os.chdir(r'D:\Хакатон')

# Загрузка данных
df = pd.read_excel("ИКРБС_2020-2024_гг..xlsx")
df.drop(["№ п/п", "Регистрационный номер"], axis=1, inplace=True)

# Чтение первых пяти строк
df = df.head()

# Функция для извлечения чисел из текста и преобразования их в float
def extract_floats(text):
    # Используем регулярные выражения для поиска чисел
    numbers = re.findall(r'\d+\.\d+', str(text))
    if numbers:
        return float(numbers[0])
    else:
        return None

# Применяем функцию к столбцу "ГРНТИ"
df["Индекс ГРНТИ"] = df["ГРНТИ"].apply(extract_floats)

# Выводим информацию о DataFrame
df.info()

# Создаем массив с данными типа float из столбца "Индекс ГРНТИ"
float_array = df["Индекс ГРНТИ"].dropna().to_numpy()

# Печатаем созданный массив
print(float_array)
