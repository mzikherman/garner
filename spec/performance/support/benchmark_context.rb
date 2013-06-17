class BenchmarkContext
  include Garner::Cache::Context

  def virtual_fetch(klass, handle)
    garner.bind(klass.identify(handle)) { klass.find(handle).to_json }
  end
  alias :a_warm_virtual_fetch :virtual_fetch
  alias :b_cold_virtual_fetch :virtual_fetch

  def class_fetch(klass, handle)
    garner.bind(klass) { klass.find(handle).to_json }
  end
  alias :c_warm_class_fetch :class_fetch
  alias :d_cold_class_fetch :class_fetch

  def force_invalidate(binding)
    binding.invalidate_garner_caches
  end
  alias :e_force_invalidate :force_invalidate

  def soft_invalidate(binding)
    binding.send(:_garner_after_update)
  end
  alias :f_soft_invalidate :soft_invalidate
end
