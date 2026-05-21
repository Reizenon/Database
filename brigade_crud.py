import psycopg2 =

# Параметры подключения к базе данных

conn = psycopg2.connect(
    host='localhost',   # Сервер 
    port='5432',        # Стандартный порт 
    dbname='Brigade', # Имя базы данных
    user='postgres',    # Имя пользователя-администратора
    password='kotolovka' # ПАРОЛЬ!
)

# Курсор 
cur = conn.cursor()


# Чтение всех записей
def get_all_soldiers():
    """Выбирает и выводит всех солдат из таблицы."""
    cur.execute("SELECT soldier_id, full_name, rank, position FROM soldiers;")
    rows = cur.fetchall() 
    for row in rows:  
        print(f"ID: {row[0]}, Имя: {row[1]}, Звание: {row[2]}, Должность: {row[3]}")
    return rows

# Получение всех солдат по подразделению 
def get_soldiers_by_unit(unit_id):
    """Выбирает солдат, которые служат в конкретном отделе (unit_id)."""
    cur.execute("SELECT soldier_id, full_name FROM soldiers WHERE unit_id = %s;", (unit_id,)) 
    return cur.fetchall()
    
# Получение одной записи по первичному ключу 
def get_soldier_by_id(soldier_id):
    """Находит и выводит одного солдата по его soldier_id."""
    cur.execute("SELECT * FROM soldiers WHERE soldier_id = %s;", (soldier_id,))
    return cur.fetchone() 

# Добавление одной записи 
def add_soldier(full_name, rank, position, unit_id):
    """Добавляет нового солдата в таблицу."""
    cur.execute("""
        INSERT INTO soldiers (full_name, rank, position, unit_id)
        VALUES (%s, %s, %s, %s) RETURNING soldier_id;
    """, (full_name, rank, position, unit_id))
    new_id = cur.fetchone()[0]
    conn.commit()
    print(f"Солдат '{full_name}' успешно добавлен с ID: {new_id}")
    return new_id

# Обновление одной записи 
def update_soldier_rank(soldier_id, new_rank):
    """Обновляет звание солдата по его ID."""
    cur.execute("UPDATE soldiers SET rank = %s WHERE soldier_id = %s;", (new_rank, soldier_id))
    conn.commit() 
    print(f"У солдата с ID {soldier_id} звание обновлено на '{new_rank}'. Изменено строк: {cur.rowcount}")
    

# Удаление одной записи 
def delete_soldier(soldier_id):
    """Удаляет солдата из таблицы по ID."""
    cur.execute("DELETE FROM soldiers WHERE soldier_id = %s;", (soldier_id,))
    conn.commit() 
    print(f"Солдат с ID {soldier_id} удален. Удалено строк: {cur.rowcount}")



if __name__ == "__main__":
    print("--- 1. Вывод всех солдат ---")
    get_all_soldiers()

    print("\n--- 2. Вывод солдат из подразделения (unit_id=5) ---")
    by_unit = get_soldiers_by_unit(5)
    for soldier in by_unit:
        print(f"ID: {soldier[0]}, Имя: {soldier[1]}")

    print("\n--- 3. Добавление нового солдата ---")
    new_id = add_soldier("Сергеев Петр Викторович", "Рядовой", "Радист", 5)

    print("\n--- 4. Поиск только что добавленного солдата по ID ---")
    new_soldier = get_soldier_by_id(new_id)
    if new_soldier:
        print(f"Найден солдат: ID={new_soldier[0]}, ФИО={new_soldier[1]}, Звание={new_soldier[2]}, Должность={new_soldier[3]}")

    print("\n--- 5. Обновление звания у нового солдата ---")
    update_soldier_rank(new_id, "Ефрейтор")

    print("\n--- 6. Удаление нового солдата!) ---")
    delete_soldier(new_id)
    
    print("\n--- 7. Финальная проверка: список солдат снова ---")
    get_all_soldiers()

    cur.close()
    conn.close()
    print("\n--- Соединение с базой данных закрыто ---")