package ga.beauty.reset.utils.runner;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintStream;
import java.util.Date;
import java.util.concurrent.Callable;
import java.util.concurrent.Executor;
import java.util.concurrent.Future;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.AsyncTaskExecutor;
import org.springframework.scheduling.SchedulingTaskExecutor;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.common.io.Files;

import ga.beauty.reset.utils.LogEnum;
import ga.beauty.reset.utils.MySDF;

@Configuration
@EnableAsync
@EnableScheduling
public class AsyncScheduleConfig {

	/* 출처 : http://dveamer.github.io/java/SpringAsync.html
	 * 출처 : https://blog.outsider.ne.kr/1066
	 * 공부해야됩니다.
	 * */
	Logger logger = Logger.getLogger(AsyncScheduleConfig.class);

	public AsyncScheduleConfig() {
		logger.info(LogEnum.INIT+"("+getClass()+") 생성완료");
	}
	
	String crashPath = "/reset/applogs/crash/";
	
	
    @Bean(name = "threadPoolTaskExecutor")
    public Executor threadPoolTaskExecutor() {
        ThreadPoolTaskExecutor taskExecutor = new ThreadPoolTaskExecutor();
        taskExecutor.setCorePoolSize(5);
        taskExecutor.setMaxPoolSize(40);
        taskExecutor.setQueueCapacity(10);
        taskExecutor.setThreadNamePrefix("Executor-");
        taskExecutor.initialize();
        return new HandlingExecutor(taskExecutor); // HandlingExecutor로 wrapping 합니다.
    }
    public class HandlingExecutor implements AsyncTaskExecutor,SchedulingTaskExecutor {
        private AsyncTaskExecutor executor;
        public HandlingExecutor(AsyncTaskExecutor executor) {
            this.executor = executor;
        }
        @Override
        public void execute(Runnable task) {
            executor.execute(task);
        }

        @Override
        public void execute(Runnable task, long startTimeout) {
            executor.execute(createWrappedRunnable(task), startTimeout);
        }
        @Override
        public Future<?> submit(Runnable task) {
            return executor.submit(createWrappedRunnable(task));
        }
        @Override
        public <T> Future<T> submit(final Callable<T> task) {
            return executor.submit(createCallable(task));
        }
        private <T> Callable<T> createCallable(final Callable<T> task) {
            return new Callable<T>() {
                @Override
                public T call() throws Exception {
                    try {
                        return task.call();
                    } catch (Exception ex) {
                        handle(ex);
                        throw ex;
                    }
                }
            };
        }
        private Runnable createWrappedRunnable(final Runnable task) {
            return new Runnable() {
                @Override
                public void run() {
                    try {
                        task.run();
                    } catch (Exception ex) {
                        try {
							handle(ex);
						} catch (FileNotFoundException e) {
							e.printStackTrace();
						}
                    }
                }
            };
        }		
        private void handle(Exception ex) throws FileNotFoundException {
            logger.error(LogEnum.ERROR_ASYNC+ex.getMessage().replace( System.getProperty( "line.separator" ), ""),ex);
            Date date = new Date();
            String fileDate = MySDF.SDF_ALL.format(date);
            File file = new File(crashPath+"/"+fileDate+"-crash.log");
            if(!file.exists())new File(file.getParent()).mkdirs();
            PrintStream test = new PrintStream(file);
            ex.printStackTrace(test);
        }
		@Override
		public boolean prefersShortLivedTasks() {
			return false;
		}

    }
}