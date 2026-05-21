import db_functions

def print_soldiers(soldiers):
    """Красиво выводит список солдат."""
    if not soldiers:
        print("  (нет данных)")
        return
    print(f"{'ID':<5} {'ФИО':<30} {'Звание':<20} {'Должность':<25} {'Подр.':<6}")
    print("-" * 90)
    for s in soldiers:
        # s – кортеж (id, full_name, rank, position, unit_id)
        print(f"{s[0]:<5} {s[1]:<30} {s[2]:<20} {s[3]:<25} {s[4]:<6}")

def show_all_soldiers():
    print("\n--- Все солдаты ---")
    soldiers = db_functions.get_all_soldiers()
    print_soldiers(soldiers)

def show_soldiers_by_unit():
    try:
        unit_id = int(input("Введите ID подразделения: "))
        soldiers = db_functions.get_soldiers_by_unit(unit_id)
        if not soldiers:
            print("В этом подразделении нет солдат.")
        else:
            print(f"\nСолдаты подразделения {unit_id}:")
            for s in soldiers:
                print(f"  ID: {s[0]}, ФИО: {s[1]}")
    except ValueError:
        print("Ошибка: ID должен быть числом.")

def show_soldier_by_id():
    try:
        sid = int(input("Введите ID солдата: "))
        soldier = db_functions.get_soldier_by_id(sid)
        if soldier:
            print("\nНайден солдат:")
            print(f"  ID: {soldier[0]}")
            print(f"  ФИО: {soldier[1]}")
            print(f"  Звание: {soldier[2]}")
            print(f"  Должность: {soldier[3]}")
            print(f"  Подразделение ID: {soldier[4]}")
        else:
            print(f"Солдат с ID {sid} не найден.")
    except ValueError:
        print("Ошибка: ID должен быть числом.")

def add_new_soldier():
    print("\n--- Добавление нового солдата ---")
    full_name = input("ФИО: ").strip()
    rank = input("Звание: ").strip()
    position = input("Должность: ").strip()
    try:
        unit_id = int(input("ID подразделения: "))
        new_id = db_functions.add_soldier(full_name, rank, position, unit_id)
        print(f"✅ Солдат успешно добавлен! Его ID = {new_id}")
    except ValueError:
        print("Ошибка: ID подразделения должен быть числом.")
    except Exception as e:
        print(f"Ошибка при добавлении: {e}")

def update_soldier():
    print("\n--- Обновление звания солдата ---")
    try:
        sid = int(input("Введите ID солдата: "))
        # Проверим, существует ли такой солдат
        soldier = db_functions.get_soldier_by_id(sid)
        if not soldier:
            print(f"Солдат с ID {sid} не найден.")
            return
        print(f"Текущее звание: {soldier[2]}")
        new_rank = input("Введите новое звание: ").strip()
        updated = db_functions.update_soldier_rank(sid, new_rank)
        if updated:
            print(f"✅ Звание солдата с ID {sid} обновлено.")
        else:
            print("Не удалось обновить (возможно, солдат не найден).")
    except ValueError:
        print("Ошибка: ID должен быть числом.")

def delete_soldier():
    print("\n--- Удаление солдата ---")
    try:
        sid = int(input("Введите ID солдата для удаления: "))
        # Проверим существование
        soldier = db_functions.get_soldier_by_id(sid)
        if not soldier:
            print(f"Солдат с ID {sid} не найден.")
            return
        print(f"Вы собираетесь удалить: {soldier[1]}, {soldier[2]}")
        confirm = input("Вы уверены? (y/n): ").lower()
        if confirm == 'y':
            deleted = db_functions.delete_soldier(sid)
            if deleted:
                print(f"✅ Солдат с ID {sid} удалён.")
            else:
                print("Не удалось удалить (возможно, солдат уже не существует).")
        else:
            print("Удаление отменено.")
    except ValueError:
        print("Ошибка: ID должен быть числом.")

def main():
    while True:
        print("\n" + "="*50)
        print("   Учёт личного состава бригады связи")
        print("="*50)
        print("1. Показать всех солдат")
        print("2. Найти солдат по подразделению")
        print("3. Найти солдата по ID")
        print("4. Добавить нового солдата")
        print("5. Обновить звание солдата")
        print("6. Удалить солдата")
        print("0. Выход")
        print("="*50)
        choice = input("Ваш выбор: ").strip()
        
        if choice == '1':
            show_all_soldiers()
        elif choice == '2':
            show_soldiers_by_unit()
        elif choice == '3':
            show_soldier_by_id()
        elif choice == '4':
            add_new_soldier()
        elif choice == '5':
            update_soldier()
        elif choice == '6':
            delete_soldier()
        elif choice == '0':
            print("До свидания!")
            break
        else:
            print("Неверный выбор. Попробуйте снова.")

if __name__ == "__main__":
    main()




#python main.py