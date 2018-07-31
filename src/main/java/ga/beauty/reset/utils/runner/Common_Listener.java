package ga.beauty.reset.utils.runner;

import java.util.List;
import java.util.concurrent.Future;

public interface Common_Listener {

	<T> Future<String> addLog(T bean, String type, int chNum) throws Exception;
	<T> List<T> getList() throws Exception;
	void saveLogOneday() throws Exception;
	void saveTmp() throws Exception;
}
