// Stream<List<CategoryWithTasks>> watchAllCategories() {
//   return (select(categories)
//         ..orderBy(([
//           (c) => OrderingTerm(expression: c.name),
//         ])))
//       .join([leftOuterJoin(tasks, tasks.categoryId.equalsExp(categories.id))])
//       .watch()
//       .map((rows) {
//         final groupedData = <Category, List<Task>>{};
//         for (final row in rows) {
//           final category = row.readTable(categories);
//           final task = row.readTable(tasks);
//           final list = groupedData.putIfAbsent(category, () => []);
//           if (task != null) list.add(task);
//         }
//         return [
//           for (final entry in groupedData.entries)
//             CategoryWithTasks(category: entry.key, tasks: entry.value)
//         ];
//       });
// }
