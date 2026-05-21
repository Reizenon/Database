import psycopg2


DB_CONFIG = {
    'host': 'localhost',
    'port': '5432',
    'dbname': 'Brigade',
    'user': 'postgres',
    'password': 'kotolovka' 
}

def get_connection():
    """Возвращает новое соединение с БД."""
    return psycopg2.connect(**DB_CONFIG)

# ---------- 1. Получение всех солдат ----------
def get_all_soldiers():
    """Возвращает список всех солдат (список кортежей)."""
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT soldier_id, full_name, rank, position, unit_id FROM soldiers ORDER BY soldier_id;")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return rows

# ---------- 2. Получение солдат по подразделению (1:N) ----------
def get_soldiers_by_unit(unit_id):
    """Возвращает солдат указанного подразделения."""
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT soldier_id, full_name FROM soldiers WHERE unit_id = %s;", (unit_id,))
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return rows

# ---------- 3. Получение одного солдата по ID ----------
def get_soldier_by_id(soldier_id):
    """Возвращает данные одного солдата или None."""
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT soldier_id, full_name, rank, position, unit_id FROM soldiers WHERE soldier_id = %s;", (soldier_id,))
    row = cur.fetchone()
    cur.close()
    conn.close()
    return row

# ---------- 4. Добавление солдата ----------
def add_soldier(full_name, rank, position, unit_id):
    """Добавляет солдата и возвращает его новый ID."""
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("""
        INSERT INTO soldiers (full_name, rank, position, unit_id)
        VALUES (%s, %s, %s, %s) RETURNING soldier_id;
    """, (full_name, rank, position, unit_id))
    new_id = cur.fetchone()[0]
    conn.commit()
    cur.close()
    conn.close()
    return new_id

# ---------- 5. Обновление звания солдата ----------
def update_soldier_rank(soldier_id, new_rank):
    """Обновляет звание, возвращает количество изменённых строк (0 или 1)."""
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("UPDATE soldiers SET rank = %s WHERE soldier_id = %s;", (new_rank, soldier_id))
    updated_count = cur.rowcount
    conn.commit()
    cur.close()
    conn.close()
    return updated_count

# ---------- 6. Удаление солдата ----------
def delete_soldier(soldier_id):
    """Удаляет солдата, возвращает количество удалённых строк."""
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("DELETE FROM soldiers WHERE soldier_id = %s;", (soldier_id,))
    deleted_count = cur.rowcount
    conn.commit()
    cur.close()
    conn.close()
    return deleted_count