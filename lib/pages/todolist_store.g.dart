// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todolist_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TodoStore on _TodoStore, Store {
  Computed<double>? _$completionPercentageComputed;

  @override
  double get completionPercentage =>
      (_$completionPercentageComputed ??= Computed<double>(
            () => super.completionPercentage,
            name: '_TodoStore.completionPercentage',
          ))
          .value;

  late final _$tasksAtom = Atom(name: '_TodoStore.tasks', context: context);

  @override
  ObservableList<Task> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<Task> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_TodoStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_TodoStore.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$_TodoStoreActionController = ActionController(
    name: '_TodoStore',
    context: context,
  );

  @override
  void loadTasks() {
    final _$actionInfo = _$_TodoStoreActionController.startAction(
      name: '_TodoStore.loadTasks',
    );
    try {
      return super.loadTasks();
    } finally {
      _$_TodoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> addTask(String title) {
    final _$actionInfo = _$_TodoStoreActionController.startAction(
      name: '_TodoStore.addTask',
    );
    try {
      return super.addTask(title);
    } finally {
      _$_TodoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> toggleCompleted(Task task, bool value) {
    final _$actionInfo = _$_TodoStoreActionController.startAction(
      name: '_TodoStore.toggleCompleted',
    );
    try {
      return super.toggleCompleted(task, value);
    } finally {
      _$_TodoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> deleteTask(String id) {
    final _$actionInfo = _$_TodoStoreActionController.startAction(
      name: '_TodoStore.deleteTask',
    );
    try {
      return super.deleteTask(id);
    } finally {
      _$_TodoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> updateTask(Task task) {
    final _$actionInfo = _$_TodoStoreActionController.startAction(
      name: '_TodoStore.updateTask',
    );
    try {
      return super.updateTask(task);
    } finally {
      _$_TodoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tasks: ${tasks},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
completionPercentage: ${completionPercentage}
    ''';
  }
}
